import { usePrisma } from "~/composables/prisma"

import { Order } from "@prisma/client"

const prisma = usePrisma();


export async function orderTicket(user: User, order: Order) {

    // await prisma.order.create({
    //     data: {
    //         user: {
    //             connect: {
    //                 phone: order.cellphone
    //             }
    //         },
    //         loginTime: '',
    //         smsCode: '',
    //         accessToken: '',
    //         refreshToken: '',
    //         seatPlantId: '',
    //         sessionId: '',
    //         showId: '',
    //         ticketPrice: 0,
    //         qty: 0,
    //         receiver: '',
    //         cellphone: '',
    //         audienceId: '',
    //         address: {
    //             connectOrCreate: {
    //                 create: {
    //                     addressId: '',
    //                     detailAddress: '',
    //                     district: '',
    //                     city: '',
    //                     province: '',
    //                 },
    //                 where: {
    //                     addressId: order.id
    //                 }
    //             }
    //         },
    //         addressId: '',
    //     },
    // })

}