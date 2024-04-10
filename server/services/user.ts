import { usePrisma } from "~/composables/prisma"

const prisma = usePrisma();

export async function getUserByPhone(phone: string, includeLogin: boolean) {
    return await prisma.user.findFirst({
        where: {
            phone: phone
        },
        include: {
            Login: {
                orderBy: {
                    loginTime: 'desc',
                },
                take: 1,
            },
        },
    })
}

export async function getUserLogin(phone: string) {
    return await getUserByPhone(phone, true);
}

export async function getSession(token: string) {
    return await prisma.login.findFirst({
        where: {
            accessToken: token
        },
        include: {
            user: true
        }
    })
}

export async function login(user: User, token: Token) {

    await prisma.login.create({
        data: {
            ...token,
            user: {
                connectOrCreate: {
                    where: {
                        phone: user.phone
                    },
                    create: user
                }
            }
        }
    })

}