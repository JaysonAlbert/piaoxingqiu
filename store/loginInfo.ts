import { defineStore } from 'pinia';

export const useLoginInfo = defineStore('loginInfo', {
    state: () => ({
        accessToken: '',
        refreshToken: '',
        smsCode: '',
        bizUserId: '',
        mtcUserId: '',
        phone: '',
        nickname: '',
        avatar: '',
    })
})