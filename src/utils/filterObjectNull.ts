export type AnyObject = Record<string, unknown>;

export function filterObjectNull<T extends AnyObject>(obj: T): Partial<T> {
  return Object.keys(obj)
      .filter((key) => obj[key] !== '' && obj[key] !== null && obj[key] !== undefined)
      .reduce((acc, key) => ({ ...acc, [key as keyof T]: obj[key] }), {});
}