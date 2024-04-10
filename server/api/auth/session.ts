import { getSession } from "@/server/services/user";

export default defineEventHandler(async (event) => {
    const token = getHeader(event, 'Authorization')
    if (token) {
        return getSession(token.split(' ')[1])
    } else {
        throw createError({
            statusCode: 501,
            statusMessage: '电话号码为空',
        });
    }
})