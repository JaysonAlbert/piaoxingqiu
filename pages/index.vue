
<template>
    <v-card class="mx-auto" max-width="450">
        <v-toolbar class="bg-white" height="88" flat>
            <template v-slot:prepend>
                <v-btn icon="mdi-google-earth">
                </v-btn>
            </template>

            <v-text-field v-model="data.search" clearable hide-details label="你想看啥" prepend-inner-icon="mdi-map-marker"
                append-inner-icon="mdi-magnify" @click:append-inner="search_shows" single-line></v-text-field>

            <template v-slot:append>
                <v-btn icon="mdi-dots-vertical"></v-btn>
            </template>
        </v-toolbar>

        <v-list lines="three">
            <v-list-item :href="'/show/' + item.showId" class="py-0" density="compact"
                v-for="(item, i) in data.search_datas" :key="i" link>
                <template class="py-0" v-slot:prepend>
                    <v-img class="h-36 w-28 m-2 p-0" :src="item.posterUrl" cover></v-img>
                </template>

                <ShowCard :show="item"></ShowCard>
            </v-list-item>
        </v-list>
    </v-card>
</template>


<script setup>

const { $error } = useNuxtApp()

const data = reactive({
    search: '',
    search_datas: []
})

const search_shows = async function () {
    const search_result = await useFetch(`cyy_gatewayapi/home/pub/v3/show_list/search?keyword=${data.search}`)

    if (search_result.data.value.statusCode !== 200) {
        $error(search_result.data.value.comments)
    }

    data.search_datas = search_result.data.value.data.searchData;
}

await search_shows()

</script>
