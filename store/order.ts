import { defineStore } from 'pinia';


export const useOrderStore = defineStore('order', {
    state: () => ({
        accessToken: null,
        seatPlanId: null,
        sessionId: null,
        showId: null,
        ticketPrice: null,
        qty: null,
        receiver: null,
        cellphone: null,
        audienceId: [],
        address: {
            addressId: '',
            detailAddress: '',
            district: '',
            city: '',
            province: ''
        }
    }),
    getters: {
        preOrder: (state) => {
            return [{
                spu: {
                    id: state.showId,
                    spuType: "SINGLE"
                },
                skus: [
                    {
                        ...state,
                        skuId: state.seatPlanId,
                        skuType: "SINGLE"
                    }
                ],

            }]
        },
    },
    actions: {
    },
})