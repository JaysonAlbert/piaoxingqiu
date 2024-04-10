const config = useRuntimeConfig()


export default defineEventHandler((event) => {
    const path = getRequestPath(event)
    const auth = getRequestHeader(event, 'Authentication')
    if (path.startsWith('/api/service') && auth != config.apiSecret) {
        throw createError({ statusCode: 401, statusMessage: 'unauthorized' })
    }
})