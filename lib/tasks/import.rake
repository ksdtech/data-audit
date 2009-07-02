# import data
namespace :import do
  desc "import student data"
  task :students => :environment do
    Student.load!
  end
  
  desc "import employee data"
  task :staff => :environment do
    Employee.load!
  end
  
  desc "init"
  task :init => :environment do
    Student.load!('student.export-200906032054.text', false)
    Employee.load!('export-200906040915.txt', false)
  end
end