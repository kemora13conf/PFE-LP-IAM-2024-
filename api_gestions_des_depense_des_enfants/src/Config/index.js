import { config } from 'dotenv';
config({ path: `.env.${process.env.NODE_ENV || 'development'}.local` });

export const { PORT, NODE_ENV, ACCESS_TOKEN_KEY, REFRESH_ACCESS_TOKEN_KEY } = process.env;