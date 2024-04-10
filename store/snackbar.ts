import { defineStore } from 'pinia';

export const useSnackbarStore = defineStore('snackbar', {
    state: () => ({
        content: '',
        color: ''
    })
})
