import { useSnackbarStore } from "@/store/snackbar";


export default defineNuxtPlugin(() => {

    const snackBar = useSnackbarStore();

    return {
        provide: {
            error: (msg: string) => {
                snackBar.$patch({
                    content: msg,
                    color: "blue-grey",
                })
            }
        }
    }
})
