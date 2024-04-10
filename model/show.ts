export type Show = {
    "showId": string,
    "showName": string,
    "stdShowId": string,
    "planHot": boolean,
    "hasPrivilege": boolean,
    "hasPriority": boolean,
    "sessionVOs": Array<Session>
}

export type Session = {
    "bizShowSessionId": string,
    "sessionName": string,
    "showId": string,
    "beginDateTime": number,
    "endDateTime": number,
    "stdShowSessionId": string,
}