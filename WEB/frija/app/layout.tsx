
import type { Metadata } from "next";
import { Geist, Geist_Mono } from "next/font/google";
import { Suspense } from "react";
import SessionHeader from "./components/SessionHeader";
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

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="es" className="h-full antialiased">
      <body className="min-h-full flex flex-col bg-[#202521] text-white">

        <header className="bg-[#fcfbf9] px-8 py-4 flex justify-between items-center border-b border-gray-200 shadow-sm w-full">

          <div className="flex items-center gap-2">
            <img
              src="/Images/logo_gral.png"
              alt="LOGO_GRAL FRIJA"
              width={200}
            />
          </div>

          <Suspense
            fallback={
              <span className="text-xs text-gray-500">
                Cargando sesión...
              </span>
            }
          >
            <SessionHeader />
          </Suspense>

        </header>

        <main className="flex-1 flex flex-col">
          {children}
        </main>

      </body>
    </html>
  );
}