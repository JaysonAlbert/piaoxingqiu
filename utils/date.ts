import moment from 'moment';

export const format_timestamp = function (timestamp: number) {
    return moment(timestamp).format('YYYY-MM-DD');
}