import type { APIRoute } from "astro";
import { sql } from "@vercel/postgres";
import { v4 as uuidv4 } from "uuid";

export const prerender = false;

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

export const GET: APIRoute = async ({ request }) => {
  console.log("GET request received");
  return new Response(JSON.stringify({ message: "Subscribe API is working" }), {
    status: 200,
    headers: { "Content-Type": "application/json" },
  });
};

export const POST: APIRoute = async ({ request }) => {
  console.log("POST request received");
  try {
    const data = await request.formData();
    const email = data.get("email")?.toString();

    console.log("Email received:", email);

    if (!email || !isValidEmail(email)) {
      return new Response(
        JSON.stringify({
          message: "Please enter a valid email address",
        }),
        { status: 400, headers: { "Content-Type": "application/json" } }
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
          { status: 403, headers: { "Content-Type": "application/json" } }
        );
      } else {
        await reactivateSubscriber(email);
        return new Response(
          JSON.stringify({
            message: "Your subscription has been reactivated!",
          }),
          { status: 200, headers: { "Content-Type": "application/json" } }
        );
      }
    }

    await addSubscriber(email);
    return new Response(
      JSON.stringify({
        message: "You are now subscribed!",
      }),
      { status: 200, headers: { "Content-Type": "application/json" } }
    );
  } catch (error) {
    console.error("Error in POST handler:", error);
    return new Response(
      JSON.stringify({
        message: "An unexpected error occurred while processing your request.",
      }),
      { status: 500, headers: { "Content-Type": "application/json" } }
    );
  }
};
