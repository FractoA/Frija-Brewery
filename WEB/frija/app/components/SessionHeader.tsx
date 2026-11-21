
import { cookies } from "next/headers";
import { verifySessionToken } from "@/lib/session";
import LogoutButton from "./LogoutButton";

export default async function SessionHeader() {
  const cookieStore = await cookies();
  const token = cookieStore.get("frija_session")?.value;

  const user = token ? verifySessionToken(token) : null;

  return (
    <div className="flex items-center gap-4">
      {user ? (
        <>
          <span className="text-xs text-gray-600 font-medium">
            {user.first_name}
          </span>

          <div className="w-8 h-8 bg-[#d9a441] rounded-full flex items-center justify-center text-gray-900 text-xs font-bold">
            {user.first_name.charAt(0).toUpperCase()}
          </div>

          <LogoutButton />
        </>
      ) : (
        <>
          <span className="text-xs text-gray-500 font-medium">
            Sin sesión iniciada
          </span>

          <div className="w-8 h-8 bg-gray-300 rounded-full flex items-center justify-center text-gray-600 text-xs font-bold">
            ?
          </div>
        </>
      )}
    </div>
  );
}