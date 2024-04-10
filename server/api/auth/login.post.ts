import { usePrisma } from "~/composables/prisma"
import axios from 'axios';

import { login } from "@/server/services/user"

export default defineEventHandler(async (event) => {

    const { cellphone, verifyCode } = await readBody(event)

    const  res  = await axios.post<ResOptions<User & Token>>('https://m.piaoxingqiu.com:443/cyy_gatewayapi/user/pub/v3/login_or_register',
        {
            cellphone,
            verifyCode
        }
    )

    if (res.data.statusCode == 200 && res.data.data != null) {
        const { bizUserId, mtcUserId, nickname, avatar, accessToken, refreshToken } = res.data.data;
        await login(
            {
                phone: cellphone,
                bizUserId,
                mtcUserId,
                nickname,
                avatar
            },
            {
                accessToken,
                refreshToken,
                smsCode: verifyCode
            }
        )
        return res.data
    }else{
        return {
            statusCode: 401,
        }
    }
})