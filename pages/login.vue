<template>
  <v-container class="d-flex align-center h-screen">
    <div class="w-100" style="display: grid; grid-template-rows: 100px 1fr;">
      <div class="text-h3" style="justify-self: center">
        票地球
      </div>
      <v-text-field class="phone" v-bind="phone" label="请输入手机号" :error-messages="errors.phone" />

      <v-row v-if="phoneValid" no-gutters class="d-flex align-center">
        <v-text-field v-bind="photo_code" label="请输入图形码" :error-messages="errors.photo_code">
          <template v-slot:append>
            <img :src="img_data" @click="get_photo_code" style="width: 6rem" />
          </template>
        </v-text-field>
      </v-row>

      <v-row no-gutters class="align-center">
        <v-text-field v-bind="password" label="请输入验证码" :error-messages="errors.password">
          <template v-slot:append>
            <count-down @click="send_sms" :disabled="!phoneValid || !codeValid" />
          </template>
        </v-text-field>
      </v-row>

      <v-btn :disabled="!phoneValid || !codeValid || !passwordValid" class="w-75 rounded-pill bg-deep-purple-lighten-2"
        size="large" @click="call_login" style="justify-self: center">立即登录</v-btn>

    </div>

  </v-container>
</template>


<script lang="ts" setup>
import { useForm, useIsFieldValid } from 'vee-validate';
import * as yup from 'yup';
import { useLoginInfo } from "~/store/loginInfo";

const { signIn } = useAuth()

definePageMeta({
  layout: "login",
  auth: false
});

const loginInfo = useLoginInfo();

const { $error } = useNuxtApp()

const send_sms = async () => {
  const loginForm = {
    "verifyCodeUseType": "USER_LOGIN",
    "cellphone": phone.value.modelValue,
    "token": photo_code.value.modelValue
  }
  const { data } = await useFetch<ResOptions<any>>('cyy_gatewayapi/user/pub/v3/send_verify_code',
    {
      method: 'post',
      body: loginForm
    })

  if (data?.value?.statusCode !== 200) {
    if (data?.value?.comments) {
      $error(data?.value?.comments)
    }
  }
}

const call_login = async () => {
  await signIn({
    cellphone: phone.value.modelValue,
    verifyCode: password.value.modelValue
  }, {
    callbackUrl: '/'
  });
}

const get_photo_code = async () => {
  const body = {
    "verifyCodeUseType": "USER_LOGIN",
    "cellphone": phone.value.modelValue
  }
  const res = await useFetch<ResOptions<any>>('/cyy_gatewayapi/user/pub/v3/generate_photo_code', {
    method: 'post',
    body
  })

  img_data.value = res.data.value?.data.baseCode
}

const { errors, defineComponentBinds } = useForm({
  validationSchema: yup.object({
    phone: yup.string().required('请输入手机号').matches(/^\d{11}$/, { message: "手机号格式错误.", excludeEmptyString: false }),
    photo_code: yup.string().required('请输入图形码').matches(/^\d{4}$/, { message: "请输入4位图形码.", excludeEmptyString: false }),
    password: yup.string().required('请输入验证码'),
  })
})

const phone = defineComponentBinds('phone')
const password = defineComponentBinds('password')
const photo_code = defineComponentBinds('photo_code')

const img_data = useState('img_data')
const phoneValid = useIsFieldValid('phone')
const codeValid = useIsFieldValid('photo_code')
const passwordValid = useIsFieldValid('password')

watch(phoneValid, async (newValue, oldValue) => {
  if (!oldValue && newValue) {
    await get_photo_code()
  }
})

</script>
<style lang="scss" scoped></style>