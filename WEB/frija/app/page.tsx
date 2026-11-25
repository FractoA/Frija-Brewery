
'use client';

import { useState } from "react";
import { useRouter } from "next/navigation";

export default function Home() {
  const router = useRouter();

  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [message, setMessage] = useState("");
  const [loading, setLoading] = useState(false);

  const handleLogin = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();

    setMessage("");
    setLoading(true);

    try {
      const response = await fetch("/api/auth/login", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          email,
          password,
        }),
      });

      const data = await response.json();

      if (!response.ok || !data.success) {
        setMessage(data.message || "No fue posible iniciar sesión.");
        return;
      }

      // Guardar los datos básicos del usuario para esta versión de prueba.
      localStorage.setItem("frija_user", JSON.stringify(data.user));

      router.push("/Inicio");

    } catch (error) {
      console.error("Error al iniciar sesión:", error);
      setMessage("No se pudo conectar con el servidor.");
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="flex-1 flex flex-col items-center justify-center px-4 py-8">

      <div className="w-full max-w-sm flex flex-col items-center">

        {/* LOGO */}
        <div className="mb-10 flex flex-col items-center">
          <img
            src="/Images/login_logo.png"
            alt="Logo FRIJA"
            width={300}
          />
        </div>

        {/* FORMULARIO */}
        <form
          className="w-full flex flex-col gap-5"
          onSubmit={handleLogin}
        >

          {/* CORREO */}
          <div className="flex flex-col gap-1.5">
            <label className="text-xs text-gray-300 font-medium">
              Correo electrónico
            </label>

            <input
              type="email"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              placeholder="admin@frija.com"
              required
              className="bg-[#fcfbf9] text-gray-800 text-sm rounded-full px-4 py-3 outline-none focus:ring-2 focus:ring-[#d9a441]"
            />
          </div>

          {/* CONTRASEÑA */}
          <div className="flex flex-col gap-1.5">
            <label className="text-xs text-gray-300 font-medium">
              Contraseña
            </label>

            <input
              type="password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              placeholder="Ingresa tu contraseña"
              required
              className="bg-[#fcfbf9] text-gray-800 text-sm rounded-full px-4 py-3 outline-none focus:ring-2 focus:ring-[#d9a441]"
            />
          </div>

          {/* MENSAJE */}
          {message && (
            <p className="text-sm text-red-400 text-center">
              {message}
            </p>
          )}

          {/* BOTÓN */}
          <button
            type="submit"
            disabled={loading}
            className="mt-3 bg-[#d9a441] hover:opacity-90 disabled:opacity-50 text-neutral-900 font-medium py-3 rounded-full transition-all shadow-md text-sm cursor-pointer"
          >
            {loading ? "Verificando..." : "Iniciar sesión"}
          </button>

        </form>

        {/* ENLACE INFERIOR */}
        <div className="mt-12">
          <a
            href="#"
            className="text-xs text-gray-400 hover:text-white transition-colors"
          >
            ¿Olvidaste tu contraseña?
          </a>
        </div>

      </div>
    </div>
  );
}