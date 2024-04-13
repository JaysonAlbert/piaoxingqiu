<template>
    <div class="pl-4 pt-4">
        场次
    </div>

    <div class="flex justify-center">
        <v-item-group v-model="data.sessionId" class="w-11/12" selected-class="bg-neutral-300">
            <v-container>
                <v-item :value="session.bizShowSessionId" v-for="session in sessions" :key="session.time"
                    v-slot="{ selectedClass, toggle }">
                    <div @click="toggle"
                        :class="['flex', 'my-2', 'px-4', 'align-center', 'border', 'rounded', 'h-10', selectedClass]">
                        {{ session.time }}
                    </div>

                </v-item>
            </v-container>
        </v-item-group>
    </div>

    <div v-if="data.sessionId && data.showId">
        <div class="pl-4">
            票价
        </div>
        <price-list v-model="data.price" v-model:seatPlanId="data.seatPlanId" :sessionId="data.sessionId"
            :showId="data.showId"></price-list>

    </div>

    <div v-if="data.price">
        <div class="pl-4">
            选择数量
        </div>
        <div>
            <tick-count v-model="data.count" :max="4"></tick-count>
        </div>
    </div>

    <v-footer class="fixed bottom-0 w-full h-20 bg-grey-lighten-1" style="position: fixed">
        <div v-if="data.price" style="color: red;">
            ¥{{ data.price * data.count }}
        </div>
        <v-btn class="relative right-4 rounded-pill bg-deep-purple-lighten-2" @click="pre_order"
            style="position: absolute">下一步</v-btn>
    </v-footer>
</template>

<script setup>

import { format_timestamp } from '~/utils/date'
import { useOrderStore } from '@/store/order'

const { token } = useAuth();
const store = useOrderStore();

const { $error } = useNuxtApp()
const router = useRouter();
const route = useRoute()

const data = reactive({
    sessionId: '',
    showId: '',
    price: null,
    count: 1,
    seatPlanId: ''
})

data.showId = route.params.showid;

const res = await useFetch(`/cyy_gatewayapi/show/pub/v3/show/${route.params.showid}/sessions_static_data`)
if (res.data.value.statusCode !== 200) {
    console.log(res.data.value)
    $error(res.data.value.comments)
}

const showInfos = res.data.value.data

const sessions = computed(() => {
    return showInfos.sessionVOs.map(v => ({
        ...v,
        time: format_timestamp(v.beginDateTime) + '~' + format_timestamp(v.endDateTime)
    }))
})

if (res.data.value.statusCode !== 200) {
    console.log(res.data.value)
    $error(res.data.value.comments)
}

const pre_order = function () {
    store.$patch({
        seatPlanId: data.seatPlanId,
        sessionId: data.sessionId,
        showId: data.showId,
        ticketPrice: data.price,
        qty: data.count
    })

    router.push({ path: '/order' })
}

</script>