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

export const buildPagination = ({
  page,
  limit,
}: PaginationInput): { skip: number; take: number } => ({
  skip: (page - 1) * limit,
  take: limit,
});

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
