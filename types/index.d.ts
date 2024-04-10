export { };

declare global {
    interface ResOptions<T> {
        statusCode?: number;
        comments?: string,
        mode?: number,
        data?: T
    }

    type Order = {
        seatPlanId?: string,
        sessionId?: string,
        showId?: string,
        ticketPrice?: number,
        qty?: number,
    }

    type User = {
        phone: string,
        nickname: string | null | undefined,
        avatar: string | null | undefined,
        bizUserId: string,
        mtcUserId: string
    }

    type Token = {
        smsCode: string,
        accessToken: string,
        refreshToken: string
    }
}