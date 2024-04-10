import { getUserLogin } from "@/server/services/user";

export default defineEventHandler(async (event) => {

    const { phone } = getQuery(event)

    if (!phone || typeof phone !== 'string') {
        throw createError({
            statusCode: 500,
            statusMessage: '电话号码为空',
        });
    }

    return getUserLogin(phone);
})