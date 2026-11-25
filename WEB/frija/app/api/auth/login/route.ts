
import { NextResponse } from "next/server";
import pool from "@/lib/db";
import bcrypt from "bcryptjs";
import type { RowDataPacket } from "mysql2";
import { createSessionToken } from "@/lib/session";

interface UserRow extends RowDataPacket {
  user_id: number;
  first_name: string;
  paternal_last_name: string;
  maternal_last_name: string | null;
  email: string;
  password: string;
  role: string;
  status: string;
  branch_id: number | null;
}

export async function POST(request: Request) {
  try {
    const { email, password } = await request.json();

    if (!email || !password) {
      return NextResponse.json(
        { success: false, message: "Ingresa tu correo y contraseña." },
        { status: 400 }
      );
    }

    const [rows] = await pool.execute<UserRow[]>(
      `SELECT user_id, first_name, paternal_last_name,
              maternal_last_name, email, password, role,
              status, branch_id
       FROM users
       WHERE email = ?
       LIMIT 1`,
      [email.trim().toLowerCase()]
    );

    if (rows.length === 0) {
      return NextResponse.json(
        { success: false, message: "Credenciales incorrectas." },
        { status: 401 }
      );
    }

    const user = rows[0];

    const passwordMatch = await bcrypt.compare(password, user.password);

    if (!passwordMatch) {
      return NextResponse.json(
        { success: false, message: "Credenciales incorrectas." },
        { status: 401 }
      );
    }

    if (user.status !== "ACTIVE") {
      return NextResponse.json(
        { success: false, message: "Tu cuenta no está activa." },
        { status: 403 }
      );
    }

    // Crear token de sesión
    const token = createSessionToken({
      user_id: user.user_id,
      first_name: user.first_name,
      role: user.role,
    });

    // Crear respuesta de inicio de sesión
    const response = NextResponse.json({
      success: true,
      message: "Inicio de sesión exitoso.",
      user: {
        user_id: user.user_id,
        first_name: user.first_name,
        paternal_last_name: user.paternal_last_name,
        maternal_last_name: user.maternal_last_name,
        email: user.email,
        role: user.role,
        branch_id: user.branch_id,
      },
    });

    // Guardar cookie de sesión
    response.cookies.set("frija_session", token, {
      httpOnly: true,
      secure: process.env.NODE_ENV === "production",
      sameSite: "lax",
      path: "/",
      maxAge: 60 * 60 * 8,
    });

    return response;

  } catch (error) {
    console.error("Error en login:", error);

    return NextResponse.json(
      { success: false, message: "Error interno del servidor." },
      { status: 500 }
    );
  }
}