export function formatTime (fmt = 'yyyy-MM-dd HH:mm:ss', timeDate: Date = new Date()): string {

    const addZeroIfRequired = (num: number): string => num < 10 ? `0${num}` : `${num}`;
    const dateSegments: Record<string, string|number> = {
        'yyyy': timeDate.getFullYear(),
        'MM':   addZeroIfRequired(timeDate.getMonth() + 1),
        'dd':   addZeroIfRequired(timeDate.getDate()),
        'HH':   addZeroIfRequired(timeDate.getHours()),
        'mm':   addZeroIfRequired(timeDate.getMinutes()),
        'ss':   addZeroIfRequired(timeDate.getSeconds()),
        'qq':   Math.floor((timeDate.getMonth() + 3) / 3),
        'S':    timeDate.getMilliseconds()
    };

    return Object.keys(dateSegments).reduce((format: string, key: string) => {
        return format.includes(key) ? format.replace(key, `${dateSegments[key]}`) : format;
    }, fmt);
}