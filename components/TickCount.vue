<template>
    <div class="flex flex-row">
        <v-icon icon="mdi-minus-box-outline" @disabled="value === 0" @click="value--" />
        <div class="mx-2">
            {{ value }}
        </div>
        <div @disabled="value >= props.max">
            <v-icon icon="mdi-plus-box-outline" @click="value++" />
        </div>

    </div>
</template>

<script setup>

const props = defineProps(['max', 'modelValue'])
const emit = defineEmits(['update:modelValue'])

const value = computed({
    get() {
        return props.modelValue;
    },

    set(newValue) {
        emit('update:modelValue', newValue)
    }
})
</script>