export type PaginationInput = {
  page: number;
  limit: number;
};

export type PaginatedResult<T> = {
  items: T[];
  page: number;
  limit: number;
  total: number;
  totalPages: number;
};

/**
 * Converts page and limit inputs into the Prisma pagination shape.
 */
export const buildPagination = ({
  page,
  limit,
}: PaginationInput): { skip: number; take: number } => ({
  skip: (page - 1) * limit,
  take: limit,
});

/**
 * Normalizes paginated persistence results into a transport-friendly shape.
 */
export const toPaginatedResult = <T>({
  items,
  total,
  page,
  limit,
}: {
  items: T[];
  total: number;
  page: number;
  limit: number;
}): PaginatedResult<T> => ({
  items,
  total,
  page,
  limit,
  totalPages: Math.max(1, Math.ceil(total / limit)),
});
