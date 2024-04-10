<template>
    <div>
        <v-snackbar :timeout="200000" v-model="data.show" :color="data.color" rounded="rounded">
            <div class="d-flex">
                {{ data.message }}
            </div>
        </v-snackbar>
    </div>
</template>

<script setup>

import { useSnackbarStore } from '@/store/snackbar';

const data = reactive({
    show: false,
    message: '',
    color: ''
})

const snackbar = useSnackbarStore();

snackbar.$subscribe((mutation, state) => {
    console.log(state)
    console.log(mutation)
    data.show = true;
    data.message = state.content;
    data.color = state.color;

    console.log(data)
})

</script>