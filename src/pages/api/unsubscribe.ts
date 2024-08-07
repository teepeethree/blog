import { sql } from "@vercel/postgres";
import type { APIRoute } from "astro";

export const POST: APIRoute = async ({ request }) => {
  const data = await request.formData();
  const email = data.get("email")?.toString();

  if (!email) {
    return new Response(
      JSON.stringify({
        message: "Email is required",
      }),
      { status: 400 }
    );
  }

  try {
    const { rowCount } = await sql`
        UPDATE subscribers SET active = false WHERE email = ${email}
      `;

    if (rowCount === 0) {
      return new Response(
        JSON.stringify({
          message: "Email not found in our subscribers list",
        }),
        { status: 404 }
      );
    }

    return new Response(
      JSON.stringify({
        message: "You have been unsubscribed successfully",
      }),
      { status: 200 }
    );
  } catch (error) {
    console.error("Unsubscribe error:", error);
    return new Response(
      JSON.stringify({
        message: "An error occurred while processing your request",
      }),
      { status: 500 }
    );
  }
};
