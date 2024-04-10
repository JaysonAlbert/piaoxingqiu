<template>
    <div class="flex flex-col">
        <div class="flex flex-col justify-between">
            <div class="text-base text-gray-500">
                {{ show?.showName }}
            </div>
            <div class="m-0.2 text-sm">
                {{ show?.showDate }}
            </div>
            <div class="m-0.2 text-sm">
                {{ show?.cityName }} | {{ show?.venueName }}
            </div>
        </div>

        <div class="flex mt-5">
            <div class="text-red-500 text-lg">
                {{ show?.minOriginalPriceInfo?.prefix + show?.minOriginalPriceInfo?.yuanNum }}
            </div>

            <div class="text-xs leading-8">
                {{ show?.minOriginalPriceInfo?.suffix }}
            </div>
        </div>
    </div>
</template>

<script setup>

const props = defineProps(['show'])

</script>