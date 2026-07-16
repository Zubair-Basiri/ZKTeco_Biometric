import { NextResponse } from "next/server";
import { getLiveDeviceFeed } from "@/lib/queries";

export const dynamic = "force-dynamic";
export const runtime = "nodejs";

export async function GET() {
  return NextResponse.json(await getLiveDeviceFeed());
}
