import type { APIRoute } from "astro";
import { sql } from "@vercel/postgres";
import { v4 as uuidv4 } from "uuid";

const isValidEmail = (email: string): boolean => {
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return emailRegex.test(email);
};

const isEmailAlreadySubscribed = async (
  email: string
): Promise<{ exists: boolean; active: boolean }> => {
  const { rows } = await sql`
    SELECT active FROM subscribers WHERE email = ${email}
  `;
  if (rows.length > 0) {
    return { exists: true, active: rows[0].active };
  }
  return { exists: false, active: false };
};

const addSubscriber = async (email: string): Promise<void> => {
  const userId = uuidv4();
  await sql`
    INSERT INTO subscribers (user_id, email, active)
    VALUES (${userId}, ${email}, true)
  `;
};

const reactivateSubscriber = async (email: string): Promise<void> => {
  await sql`
    UPDATE subscribers SET active = true WHERE email = ${email}
  `;
};

export const POST: APIRoute = async ({ request }) => {
  try {
    const data = await request.formData();
    const email = data.get("email")?.toString();

    if (!email || !isValidEmail(email)) {
      return new Response(
        JSON.stringify({
          message: "Please enter a valid email address",
        }),
        { status: 400 }
      );
    }

    const { exists, active } = await isEmailAlreadySubscribed(email);

    if (exists) {
      if (active) {
        return new Response(
          JSON.stringify({
            message:
              "You're already subscribed! I appreciate your enthusiasm though!",
          }),
          { status: 403 }
        );
      } else {
        await reactivateSubscriber(email);
        return new Response(
          JSON.stringify({
            message: "Your subscription has been reactivated!",
          }),
          { status: 200 }
        );
      }
    }

    await addSubscriber(email);
    return new Response(
      JSON.stringify({
        message: "You are now subscribed!",
      }),
      { status: 200 }
    );
  } catch (error) {
    console.error("Subscription error:", error);
    if (error instanceof Error) {
      return new Response(
        JSON.stringify({
          message: `An error occurred: ${error.message}`,
        }),
        { status: 500 }
      );
    }
    return new Response(
      JSON.stringify({
        message: "An unexpected error occurred while processing your request.",
      }),
      { status: 500 }
    );
  }
};
