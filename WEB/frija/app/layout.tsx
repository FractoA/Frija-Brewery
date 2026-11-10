import type { Metadata } from "next";
import { Geist, Geist_Mono } from "next/font/google";
import "./globals.css";

const geistSans = Geist({
  variable: "--font-geist-sans",
  subsets: ["latin"],
});

const geistMono = Geist_Mono({
  variable: "--font-geist-mono",
  subsets: ["latin"],
});

export const metadata: Metadata = {
  title: "FRIJA",
  description: "Distribution",
};

import "./globals.css";

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="es" className="h-full antialiased">
      <body className="min-h-full flex flex-col bg-[#202521] text-white">
        
        {/* FRANJA BLANCA SUPERIOR (HEADER GLOBAL) */}
        <header className="bg-[#fcfbf9] px-8 py-4 flex justify-between items-center border-b border-gray-200 shadow-sm w-full">
          {/* Espacio para tu logo (Izquierda) */}
          <div className="flex items-center gap-2">
            <span className="text-gray-400 text-xs italic">
              <img src="/Images/logo_gral.png" alt="LOGO_GRAL FRIJA" width={200} />
            </span>
          </div>
          
          {/* Sin cuenta activa */}
          <div className="flex items-center gap-3">
            <span className="text-xs text-gray-500 font-medium">
              Sin sesión iniciada
            </span>
            {/*Un círculo gris genérico o botón de login */}
            <div className="w-8 h-8 bg-gray-300 rounded-full flex items-center justify-center text-gray-600 text-xs font-bold">
              ?
            </div>
          </div>
        </header>

        {/* CONTENIDO DE LAS PÁGINAS */}
        <main className="flex-1 flex flex-col">
          {children}
        </main>

      </body>
    </html>
  );
}