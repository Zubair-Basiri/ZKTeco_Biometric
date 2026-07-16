"use client";

import type { ReactNode } from "react";
import { useMemo, useState } from "react";
import { ChevronLeft, ChevronRight } from "lucide-react";

type PaginatedTableProps<T> = {
  rows: T[];
  pageSize?: number;
  emptyState: ReactNode;
  mobileEmptyState?: ReactNode;
  header: ReactNode;
  getKey: (row: T) => string;
  renderRow: (row: T) => ReactNode;
  renderMobileCard?: (row: T) => ReactNode;
};

export function PaginatedTable<T>({
  rows,
  pageSize = 10,
  emptyState,
  mobileEmptyState,
  header,
  getKey,
  renderRow,
  renderMobileCard,
}: PaginatedTableProps<T>) {
  const [page, setPage] = useState(1);

  const totalPages = Math.max(1, Math.ceil(rows.length / pageSize));
  const safePage = Math.min(page, totalPages);

  const currentRows = useMemo(() => {
    const start = (safePage - 1) * pageSize;
    return rows.slice(start, start + pageSize);
  }, [pageSize, rows, safePage]);

  const startRow = rows.length === 0 ? 0 : (safePage - 1) * pageSize + 1;
  const endRow = Math.min(safePage * pageSize, rows.length);
  const hasMobileCards = typeof renderMobileCard === "function";

  return (
    <div className="space-y-4">
      {hasMobileCards ? (
        <div className="md:hidden space-y-3">
          {currentRows.length === 0
            ? mobileEmptyState ?? (
              <div className="rounded-[24px] border border-stone-200 bg-white px-4 py-8 text-center text-sm text-slate-500">
                No records found.
              </div>
            )
            : currentRows.map((row) => (
              <article key={getKey(row)} className="rounded-[24px] border border-stone-200 bg-white p-4 shadow-sm">
                {renderMobileCard(row)}
              </article>
            ))}
        </div>
      ) : null}

      <div className={hasMobileCards ? "hidden overflow-x-auto md:block" : "overflow-x-auto"}>
        <table className="min-w-full text-left text-sm text-slate-700">
          <thead className="text-xs uppercase tracking-[0.18em] text-slate-500">{header}</thead>
          <tbody>
            {currentRows.length === 0
              ? emptyState
              : currentRows.map((row) => <tr key={getKey(row)} className="border-t border-stone-200 align-top">{renderRow(row)}</tr>)}
          </tbody>
        </table>
      </div>

      <div className="flex flex-col gap-3 rounded-[24px] border border-stone-200 bg-stone-50/80 px-4 py-3 text-sm text-slate-600 md:flex-row md:items-center md:justify-between">
        <p>
          Showing {startRow}-{endRow} of {rows.length}
        </p>
        <div className="flex items-center gap-2">
          <button
            type="button"
            onClick={() => setPage((current) => Math.max(1, current - 1))}
            disabled={safePage === 1}
            className="inline-flex items-center gap-2 rounded-2xl border border-stone-200 bg-white px-3 py-2 text-sm text-slate-700 transition disabled:cursor-not-allowed disabled:opacity-50 hover:bg-stone-100"
          >
            <ChevronLeft className="h-4 w-4" />
            Previous
          </button>
          <div className="rounded-2xl border border-stone-200 bg-white px-3 py-2 text-sm font-medium text-slate-900">
            Page {safePage} of {totalPages}
          </div>
          <button
            type="button"
            onClick={() => setPage((current) => Math.min(totalPages, current + 1))}
            disabled={safePage === totalPages}
            className="inline-flex items-center gap-2 rounded-2xl border border-stone-200 bg-white px-3 py-2 text-sm text-slate-700 transition disabled:cursor-not-allowed disabled:opacity-50 hover:bg-stone-100"
          >
            Next
            <ChevronRight className="h-4 w-4" />
          </button>
        </div>
      </div>
    </div>
  );
}