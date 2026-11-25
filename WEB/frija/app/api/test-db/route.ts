
import { NextResponse } from "next/server";
import pool from "@/lib/db";

export async function GET() {
  try {
    const [rows] = await pool.query(
      "SELECT user_id, first_name, email, role, status FROM users"
    );

    return NextResponse.json({
      success: true,
      message: "Conexión a MariaDB exitosa",
      users: rows,
    });
  } catch (error) {
    console.error("Error de conexión:", error);

    return NextResponse.json(
      {
        success: false,
        message: "No se pudo conectar a MariaDB",
      },
      { status: 500 }
    );
  }
}