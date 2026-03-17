import {
  buildPagination,
  toPaginatedResult,
} from 'common/database/helpers/pagination.helper';

// ---------------------------------------------------------------------------
// buildPagination
// ---------------------------------------------------------------------------

describe('buildPagination', () => {
  it('returns skip=0, take=limit for the first page', () => {
    expect(buildPagination({ page: 1, limit: 20 })).toEqual({ skip: 0, take: 20 });
  });

  it('returns correct skip for subsequent pages', () => {
    expect(buildPagination({ page: 2, limit: 20 })).toEqual({ skip: 20, take: 20 });
    expect(buildPagination({ page: 3, limit: 20 })).toEqual({ skip: 40, take: 20 });
    expect(buildPagination({ page: 3, limit: 10 })).toEqual({ skip: 20, take: 10 });
  });

  it('sets take equal to limit regardless of page', () => {
    expect(buildPagination({ page: 1, limit: 1 }).take).toBe(1);
    expect(buildPagination({ page: 5, limit: 50 }).take).toBe(50);
    expect(buildPagination({ page: 100, limit: 100 }).take).toBe(100);
  });

  it('handles limit=1 for one-at-a-time pagination', () => {
    expect(buildPagination({ page: 1, limit: 1 })).toEqual({ skip: 0, take: 1 });
    expect(buildPagination({ page: 5, limit: 1 })).toEqual({ skip: 4, take: 1 });
  });
});

// ---------------------------------------------------------------------------
// toPaginatedResult
// ---------------------------------------------------------------------------

describe('toPaginatedResult', () => {
  it('passes through items, page, limit, and total unchanged', () => {
    const items = [{ id: 'a' }, { id: 'b' }];
    const result = toPaginatedResult({ items, total: 50, page: 3, limit: 10 });

    expect(result.items).toBe(items);
    expect(result.total).toBe(50);
    expect(result.page).toBe(3);
    expect(result.limit).toBe(10);
  });

  it('calculates totalPages for an exact multiple of limit', () => {
    expect(toPaginatedResult({ items: [], total: 40, page: 1, limit: 20 }).totalPages).toBe(2);
    expect(toPaginatedResult({ items: [], total: 100, page: 1, limit: 10 }).totalPages).toBe(10);
  });

  it('rounds totalPages up when items do not fill the last page', () => {
    expect(toPaginatedResult({ items: [], total: 41, page: 1, limit: 20 }).totalPages).toBe(3);
    expect(toPaginatedResult({ items: [], total: 1, page: 1, limit: 20 }).totalPages).toBe(1);
    expect(toPaginatedResult({ items: [], total: 21, page: 1, limit: 20 }).totalPages).toBe(2);
  });

  it('returns totalPages=1 when total is 0 (never returns 0 pages)', () => {
    const result = toPaginatedResult({ items: [], total: 0, page: 1, limit: 20 });
    expect(result.totalPages).toBe(1);
  });

  it('returns totalPages=1 when total exactly equals limit', () => {
    expect(toPaginatedResult({ items: [], total: 20, page: 1, limit: 20 }).totalPages).toBe(1);
  });

  it('handles limit=1 correctly across multiple items', () => {
    expect(toPaginatedResult({ items: ['a'], total: 5, page: 1, limit: 1 }).totalPages).toBe(5);
    expect(toPaginatedResult({ items: ['a'], total: 1, page: 1, limit: 1 }).totalPages).toBe(1);
  });

  it('handles limit=100 (max allowed) correctly', () => {
    const result = toPaginatedResult({ items: [], total: 250, page: 1, limit: 100 });
    expect(result.totalPages).toBe(3);
  });
});
