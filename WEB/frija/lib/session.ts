
import { createHmac, timingSafeEqual } from "node:crypto";

export interface SessionUser {
  user_id: number;
  first_name: string;
  role: string;
}

function getSecret() {
  const secret = process.env.SESSION_SECRET;

  if (!secret) {
    throw new Error("Falta configurar SESSION_SECRET");
  }

  return secret;
}

export function createSessionToken(user: SessionUser) {
  const payload = Buffer.from(JSON.stringify(user)).toString("base64url");

  const signature = createHmac("sha256", getSecret())
    .update(payload)
    .digest("base64url");

  return `${payload}.${signature}`;
}

export function verifySessionToken(token: string): SessionUser | null {
  try {
    const [payload, signature] = token.split(".");

    if (!payload || !signature) return null;

    const expected = createHmac("sha256", getSecret())
      .update(payload)
      .digest("base64url");

    const receivedBuffer = Buffer.from(signature);
    const expectedBuffer = Buffer.from(expected);

    if (
      receivedBuffer.length !== expectedBuffer.length ||
      !timingSafeEqual(receivedBuffer, expectedBuffer)
    ) {
      return null;
    }

    return JSON.parse(
      Buffer.from(payload, "base64url").toString("utf8")
    ) as SessionUser;
  } catch {
    return null;
  }
}