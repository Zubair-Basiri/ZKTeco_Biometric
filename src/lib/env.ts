import { z } from "zod";

const envSchema = z.object({
  DATABASE_URL: z.string().min(1),
  ZK_DEFAULT_PORT: z.coerce.number().int().positive().default(4370),
  ZK_TIMEOUT_MS: z.coerce.number().int().positive().default(10_000),
  ZK_INPORT: z.coerce.number().int().positive().default(4000),
  LIVE_SYNC_INTERVAL_MS: z.coerce.number().int().positive().default(30_000),
});

export const env = envSchema.parse({
  DATABASE_URL: process.env.DATABASE_URL,
  ZK_DEFAULT_PORT: process.env.ZK_DEFAULT_PORT ?? 4370,
  ZK_TIMEOUT_MS: process.env.ZK_TIMEOUT_MS ?? 10_000,
  ZK_INPORT: process.env.ZK_INPORT ?? 4000,
  LIVE_SYNC_INTERVAL_MS: process.env.LIVE_SYNC_INTERVAL_MS ?? 30_000,
});
