<template>
    <v-btn class="text-blue-darken-4" :disabled="props.disabled || data.isCountingDown" variant="text"
        @click="startCountdown" style="width: 6rem">{{ showText }}</v-btn>
</template>

<script setup>

const props = defineProps(['disabled'])

const emit = defineEmits(['click'])


const data = reactive({
    countdown: 60,
    isCountingDown: false,
})

const showText = computed(() => {
    return data.isCountingDown ? data.countdown + 's' : '获取验证码'
})

const startCountdown = () => {
    if (!data.isCountingDown) {
        data.isCountingDown = true;
        emit('click');
        data.countdown = 60;
        let timer = setInterval(() => {
            data.countdown--;
            if (data.countdown === 0) {
                clearInterval(timer);
                data.isCountingDown = false;
            }
        }, 1000);
    }
}
</script>
