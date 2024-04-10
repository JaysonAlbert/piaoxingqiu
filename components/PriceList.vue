<template>
    <div class="flex justify-center">
        <v-chip-group selected-class="text-primary" class="m-2 p-2" v-model="seatPlanId" density="comfortable"
            variant="tonal">
            <v-chip :value="price.seatPlanId" v-for="price in data.prices" :key="price.seatPlanId">
                {{ price.seatPlanName }} {{ price.comments }}
            </v-chip>
        </v-chip-group>
    </div>
</template>

<script setup>
import _ from 'lodash'

const emit = defineEmits(['update:modelValue', 'update:seatPlanId'])

const { $error } = useNuxtApp();

const data = reactive({
    prices: [],
})

const props = defineProps(['showId', 'sessionId', 'modelValue', 'seatPlanId'])

watch(() => props.sessionId, async (newSession, oldSession) => {
    emit('update:modelValue', null);
    if (!newSession) {
        return;
    }

    await update_prices(newSession);
})

const seatPlanId = computed({
    get() {
        return props.seatPlanId
    },
    set(newValue) {
        if (!newValue) {
            emit('update:modelValue', null)
            emit('update:seatPlanId', null)
        }
        const price = _.find(data.prices, v => v.seatPlanId == newValue).originalPrice
        emit('update:modelValue', price)
        emit('update:seatPlanId', newValue)
    }
})

const update_prices = async function (sessionId) {
    const res = await useFetch(`/cyy_gatewayapi/show/pub/v3/show/${props.showId}/show_session/${sessionId}/seat_plans_static_data`)
    if (res.data.value.statusCode !== 200) {
        $error(res.data.value.comments)
        return;
    }
    data.prices = res.data.value.data.seatPlans;
}

if (props.sessionId) {
    await update_prices(props.sessionId);
}

</script>