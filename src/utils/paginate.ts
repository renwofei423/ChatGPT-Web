const DEFAULT_PAGE_SIZE = 10;

export function paginate<T>(list: Array<T>, page: number, pageSize = DEFAULT_PAGE_SIZE): Array<T> {
    const startIndex = (page - 1) * pageSize;
    return list.slice(startIndex, startIndex + pageSize);
}