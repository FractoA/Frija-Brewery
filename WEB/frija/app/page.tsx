'use client';
import Image from "next/image";


export default function Home() {
return (
    <div className="flex-1 flex flex-col items-center justify-center px-4 py-8">
      
      {/* Contenedor principal de la tarjeta de login */}
      <div className="w-full max-w-sm flex flex-col items-center">
        
        {/* LOGO*/}
        <div className="mb-10 flex flex-col items-center">
          <div className="text-white mb-2">
            <img src="/Images/login_logo.png" alt="Logo_FRIJA" width={300}/>
          </div>
        </div>

        {/* FORMULARIO */}
        <form className="w-full flex flex-col gap-5" onSubmit={(e) => e.preventDefault()}>
          
          {/* Campo Username */}
          <div className="flex flex-col gap-1.5">
            <label className="text-xs text-gray-300 font-medium">Username</label>
            <input 
              type="text" 
              defaultValue="Admin"
              className="bg-[#fcfbf9] text-gray-800 text-sm rounded-full px-4 py-3 outline-none focus:ring-2 focus:ring-[#d9a441]"
            />
          </div>

          {/* Campo Password */}
          <div className="flex flex-col gap-1.5">
            <label className="text-xs text-gray-300 font-medium">Password</label>
            <input 
              type="password" 
              defaultValue="************"
              className="bg-[#fcfbf9] text-gray-800 text-sm rounded-full px-4 py-3 outline-none focus:ring-2 focus:ring-[#d9a441]"
            />
          </div>

          {/* Botón Iniciar sesión */}
          <button 
            type="submit"
            className="mt-3 bg-[#d9a441] hover:cmyk text-neutral-900 font-medium py-3 rounded-full transition-all shadow-md text-sm cursor-pointer"
          >
            <a href="/Inicio">Iniciar sesión</a>
            
          </button>
        </form>

        {/* ENLACE INFERIOR */}
        <div className="mt-12">
          <a href="#" className="text-xs text-gray-400 hover:text-white transition-colors">
            ¿Olvidaste tu contraseña?
          </a>
        </div>

      </div>

    </div>
  );
}
