<template>
    <div class="flex flex-col justify-center mx-3 my-1">
        <v-card class="my-1">
            <div class="p-2" v-if="show">
                <div class="flex flex-row">
                    <v-img class="w-25 aspect-[4/3]" :src="show.poster"></v-img>
                    <div>
                        <div class="">
                            {{ show.showName }}
                        </div>
                        <div class="text-sm">
                            {{ show.cityName }} | {{ show.venue.venueName }}
                        </div>
                    </div>

                </div>
                {{ show.showTimeDesc }}
                <div>
                    <v-chip variant="text" class="mx-1" size="small"
                        :prepend-icon="note.type ? 'mdi-check-circle-outline' : 'mdi-close-circle-outline'"
                        v-for=" note in show.showNotes" :key="note.name"> {{ note.name
                        }}</v-chip>
                </div>
            </div>

        </v-card>
        <v-card title="实名观演/赛人" :subtitle="audience_subtitle" class="my-2">

            <v-list v-model:selected="data.choices" density="comfortable" base-color="black" color="purple"
                select-strategy="classic" v-model="data.choices">
                <v-list-item :title="audience.name" :subtitle="audience.description + audience.idNo" :value="audience.id"
                    v-for="audience in data.audiences" :key="audience.id">
                    <template v-slot:append="{ isActive }">
                        <v-icon v-if="isActive" size="small" icon="mdi-check-circle"></v-icon>
                        <v-icon v-else size="small" icon="mdi-circle-outline"> </v-icon>
                    </template>
                </v-list-item>
            </v-list>

        </v-card>

        <v-card class="my-2">
            <div class="p-5">
                {{ deliveries.displayName }}
            </div>
        </v-card>

        <v-card v-if="data.address">
            <div class="d-flex align-center justify-between p-1">
                <div class="p-3">
                    <div class="text-xs text-gray-500 py-2">收货地址</div>

                    <div class="d-flex flex-row py-1">
                        <div class="pr-3"> {{ data.address.username }}</div>
                        <div> {{ data.address.cellphone }}</div>
                    </div>
                    <div class="text-xs text-gray-500">
                        {{ data.address.detailAddress }}
                    </div>
                </div>
                <v-icon icon="mdi-chevron-right"></v-icon>
            </div>
        </v-card>

        <div class="flex justify-center pt-4">
            <v-btn class="w-75 rounded-pill bg-deep-purple-lighten-2" size="large" @click="placeOrder">立即下单</v-btn>
        </div>

    </div>
</template>

<script setup>
import { useOrderStore } from '@/store/order'
import _ from 'lodash';

const { $error } = useNuxtApp();

const { token } = useAuth()

const store = useOrderStore();

const data = reactive({
    audiences: [],
    choices: [],
    preOrderResult: null,
    address: null
})

const res = await useFetch('/cyy_gatewayapi/user/buyer/v3/user_audiences', {
    headers: {
        'access-token': token.value.split(' ')[1]
    }
})


if (res.data.value.statusCode !== 200) {
    $error(res.data.value.comments)
} else {
    data.audiences = res.data.value.data
}

const audience_subtitle = computed(() => {
    return `已选${data.choices.length}/${data.audiences.length}位，入场时需携带对应证件`
})

const show = computed(() => {
    return data.preOrderResult?.shows[0];
})

const deliveries = computed(() => {
    return data.preOrderResult?.supportDeliveries[0]
})

const pd = await useFetch('/cyy_gatewayapi/trade/buyer/order/v3/pre_order', {
    method: 'post',
    headers: {
        'access-token': token.value.split(' ')[1]
    },
    body: {
        items: store.preOrder
    }
})

if (pd.data.value.statusCode !== 200) {
    $error(pd.data.value.comments)
} else {
    data.preOrderResult = pd.data.value.data
}

const ad = await useFetch('/cyy_gatewayapi/user/buyer/v3/user/addresses/default', {
    headers: {
        'access-token': token.value.split(' ')[1]
    }
})

if (ad.data.value.statusCode !== 200) {
    $error(pd.data.value.comments)
} else {
    if(!ad.data.value.result.cellphone){
        $error('请设置默认地址')
    }else{
        data.address = ad.data.value.data
    }
}

const placeOrder = function () {
    if (data.choices.length !== store.qty) {
        $error(`请选择${store.qty}位观影人`);
        return;
    }

    store.$patch({
        accessToken: token.value.split(' ')[1],
        receiver: data.address.username,
        cellphone: data.address.cellphone,
        audienceId: data.choices,
        address: {
            addressId: data.address.addressId,
            detailAddress: data.address.detailAddress,
            district: data.address.location.district,
            city: data.address.location.city,
            province: data.address.location.province
        }
    })


}

</script>
