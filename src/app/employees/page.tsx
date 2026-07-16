import { EmployeeDirectoryTable } from "@/components/employee-directory-table";
import { FeedbackModal } from "@/components/feedback-modal";
import { SectionCard } from "@/components/section-card";
import { readFeedback } from "@/lib/helpers";
import { getEmployeesPageData } from "@/lib/queries";

export const dynamic = "force-dynamic";

type PageProps = {
  searchParams?: Promise<Record<string, string | string[] | undefined>>;
};

export default async function EmployeesPage({ searchParams }: PageProps) {
  const [data, feedback] = await Promise.all([
    getEmployeesPageData(),
    readFeedback(searchParams),
  ]);

  return (
    <div className="space-y-8">
     
      <FeedbackModal feedback={feedback} />

    

      <SectionCard
        eyebrow="Directory"
        title="Mirrored device users"
      >
        <EmployeeDirectoryTable employees={data.employees} />
      </SectionCard>
    </div>
  );
}
