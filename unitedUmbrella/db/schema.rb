# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 0) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "edprojectattributes", id: false, force: :cascade do |t|
    t.string "source",      limit: 80
    t.string "name",        limit: 30
    t.string "description", limit: 160
    t.string "samplevalue", limit: 80
  end

  create_table "edprojectattributescopy", id: false, force: :cascade do |t|
    t.string "source",      limit: 80
    t.string "name",        limit: 30
    t.string "description", limit: 160
    t.string "samplevalue", limit: 80
  end

  create_table "private_schools_elementary_enrollment", primary_key: ["aun", "academic_year_start", "academic_year_end"], force: :cascade do |t|
    t.integer "aun",                            null: false
    t.integer "academic_year_start",            null: false
    t.integer "academic_year_end",              null: false
    t.string  "category",            limit: 20
    t.integer "k4pp"
    t.integer "k4fpf"
    t.integer "k5pp"
    t.integer "k5fpf"
    t.integer "onepp"
    t.integer "onefpf"
    t.integer "twopp"
    t.integer "twofpf"
    t.integer "threepp"
    t.integer "threefpf"
    t.integer "fourpp"
    t.integer "fourfpf"
    t.integer "fivepp"
    t.integer "fivefpf"
    t.integer "sixpp"
    t.integer "sixfpf"
    t.integer "sevenepp"
    t.integer "sevenefpf"
    t.integer "eightepp"
    t.integer "eightefpf"
    t.integer "eugpp"
    t.integer "eugfpf"
    t.integer "totalee"
    t.integer "totalnrpp"
    t.integer "totalnrfpf"
    t.integer "totalrpp"
    t.integer "totalrfpf"
  end

  create_table "private_schools_enrollment", primary_key: "aun", id: :integer, force: :cascade do |t|
    t.string  "name",      limit: 100
    t.string  "mail_adr",  limit: 100
    t.string  "loc_adr",   limit: 100
    t.integer "total_enr",             null: false
    t.integer "iu"
    t.string  "county",    limit: 50
  end

  create_table "private_schools_fulltime_equivalent_teachers", primary_key: ["aun", "academic_year_start", "academic_year_end"], force: :cascade do |t|
    t.integer "aun",                            null: false
    t.integer "academic_year_start",            null: false
    t.integer "academic_year_end",              null: false
    t.string  "category",            limit: 20
    t.float   "nurseryfte"
    t.float   "elementaryfte"
    t.float   "secondaryfte"
    t.float   "spedpreschfte"
    t.float   "totalfte"
  end

  create_table "private_schools_other_enrollment", primary_key: ["aun", "academic_year_start", "academic_year_end"], force: :cascade do |t|
    t.integer "aun",                  null: false
    t.integer "academic_year_start",  null: false
    t.integer "academic_year_end",    null: false
    t.integer "npp"
    t.integer "nfpf"
    t.integer "spedpreschk5pp"
    t.integer "spedpreschk5fpf"
    t.integer "spedpreschnurs345pp"
    t.integer "spedpreschnurs345fpf"
    t.integer "age21pluspp"
    t.integer "age21plusfpf"
    t.integer "totaloe"
    t.integer "nrpp"
    t.integer "nrfpf"
    t.integer "rpp"
    t.integer "rfpf"
  end

  create_table "private_schools_percentage_low_income", primary_key: ["aun", "academic_year_start", "academic_year_end"], force: :cascade do |t|
    t.integer "aun",                            null: false
    t.integer "academic_year_start",            null: false
    t.integer "academic_year_end",              null: false
    t.string  "category",            limit: 20
    t.float   "nurserypercent"
    t.float   "kto12percent"
  end

  create_table "private_schools_secondary_enrollment", primary_key: ["aun", "academic_year_start", "academic_year_end"], force: :cascade do |t|
    t.integer "aun",                 null: false
    t.integer "academic_year_start", null: false
    t.integer "academic_year_end",   null: false
    t.integer "sevenspp"
    t.integer "sevensfpf"
    t.integer "eightspp"
    t.integer "eightsfpf"
    t.integer "ninepp"
    t.integer "ninefpf"
    t.integer "tenpp"
    t.integer "tenfpf"
    t.integer "elevenpp"
    t.integer "elevenfpf"
    t.integer "twelvepp"
    t.integer "twelvefpf"
    t.integer "sugpp"
    t.integer "sugfpf"
    t.integer "totalse"
    t.integer "nrpp"
    t.integer "nrfpf"
    t.integer "rpp"
    t.integer "rfpf"
  end

  create_table "public_lea", primary_key: "aun", id: :integer, force: :cascade do |t|
    t.string "lea_name", limit: 100
    t.string "lea_type", limit: 50
    t.string "county",   limit: 50
  end

  create_table "public_lea_race_backup", id: false, force: :cascade do |t|
    t.integer "academic_year_start"
    t.integer "academic_year_end"
    t.integer "aun"
    t.string  "lea_name",            limit: 100
    t.string  "lea_type",            limit: 50
    t.string  "county",              limit: 50
    t.string  "race",                limit: 100
    t.integer "pka"
    t.integer "pkp"
    t.integer "pkf"
    t.integer "k4a"
    t.integer "k4p"
    t.integer "k4f"
    t.integer "k5a"
    t.integer "k5p"
    t.integer "k5f"
    t.integer "grade1"
    t.integer "grade2"
    t.integer "grade3"
    t.integer "grade4"
    t.integer "grade5"
    t.integer "grade6"
    t.integer "eug"
    t.integer "grade7"
    t.integer "grade8"
    t.integer "grade9"
    t.integer "grade10"
    t.integer "grade11"
    t.integer "grade12"
    t.integer "sug"
    t.integer "total"
  end

  create_table "public_lea_race_enrollment", primary_key: ["academic_year_start", "academic_year_end", "aun", "race"], force: :cascade do |t|
    t.integer "academic_year_start",             null: false
    t.integer "academic_year_end",               null: false
    t.integer "aun",                             null: false
    t.string  "race",                limit: 100, null: false
    t.integer "pka"
    t.integer "pkp"
    t.integer "pkf"
    t.integer "k4a"
    t.integer "k4p"
    t.integer "k4f"
    t.integer "k5a"
    t.integer "k5p"
    t.integer "k5f"
    t.integer "grade1"
    t.integer "grade2"
    t.integer "grade3"
    t.integer "grade4"
    t.integer "grade5"
    t.integer "grade6"
    t.integer "eug"
    t.integer "grade7"
    t.integer "grade8"
    t.integer "grade9"
    t.integer "grade10"
    t.integer "grade11"
    t.integer "grade12"
    t.integer "sug"
    t.integer "total"
  end

  create_table "public_lea_school_backup", id: false, force: :cascade do |t|
    t.integer "academic_year_start"
    t.integer "academic_year_end"
    t.integer "aun"
    t.string  "lea_name",            limit: 100
    t.string  "lea_type",            limit: 50
    t.string  "county",              limit: 50
    t.integer "school_id"
    t.string  "school_name",         limit: 100
    t.integer "pka"
    t.integer "pkp"
    t.integer "pkf"
    t.integer "k4a"
    t.integer "k4p"
    t.integer "k4f"
    t.integer "k5a"
    t.integer "k5p"
    t.integer "k5f"
    t.integer "grade1"
    t.integer "grade2"
    t.integer "grade3"
    t.integer "grade4"
    t.integer "grade5"
    t.integer "grade6"
    t.integer "eug"
    t.integer "grade7"
    t.integer "grade8"
    t.integer "grade9"
    t.integer "grade10"
    t.integer "grade11"
    t.integer "grade12"
    t.integer "sug"
    t.integer "total"
  end

  create_table "public_lea_school_gender_backup", id: false, force: :cascade do |t|
    t.integer "academic_year_start"
    t.integer "academic_year_end"
    t.integer "aun"
    t.string  "lea_name",            limit: 100
    t.string  "lea_type",            limit: 50
    t.string  "county",              limit: 50
    t.integer "school_id"
    t.string  "school_name",         limit: 100
    t.string  "gender",              limit: 1
    t.integer "pka"
    t.integer "pkp"
    t.integer "pkf"
    t.integer "k4a"
    t.integer "k4p"
    t.integer "k4f"
    t.integer "k5a"
    t.integer "k5p"
    t.integer "k5f"
    t.integer "grade1"
    t.integer "grade2"
    t.integer "grade3"
    t.integer "grade4"
    t.integer "grade5"
    t.integer "grade6"
    t.integer "eug"
    t.integer "grade7"
    t.integer "grade8"
    t.integer "grade9"
    t.integer "grade10"
    t.integer "grade11"
    t.integer "grade12"
    t.integer "sug"
    t.integer "total"
  end

  create_table "public_school_enrollment", primary_key: ["academic_year_start", "academic_year_end", "school_id"], force: :cascade do |t|
    t.integer "academic_year_start", null: false
    t.integer "academic_year_end",   null: false
    t.integer "school_id",           null: false
    t.integer "aun"
    t.integer "pka"
    t.integer "pkp"
    t.integer "pkf"
    t.integer "k4a"
    t.integer "k4p"
    t.integer "k4f"
    t.integer "k5a"
    t.integer "k5p"
    t.integer "k5f"
    t.integer "grade1"
    t.integer "grade2"
    t.integer "grade3"
    t.integer "grade4"
    t.integer "grade5"
    t.integer "grade6"
    t.integer "eug"
    t.integer "grade7"
    t.integer "grade8"
    t.integer "grade9"
    t.integer "grade10"
    t.integer "grade11"
    t.integer "grade12"
    t.integer "sug"
    t.integer "total"
  end

  create_table "public_school_gender_enrollment", primary_key: ["academic_year_start", "academic_year_end", "school_id", "gender"], force: :cascade do |t|
    t.integer "academic_year_start",           null: false
    t.integer "academic_year_end",             null: false
    t.integer "school_id",                     null: false
    t.integer "aun"
    t.string  "gender",              limit: 1, null: false
    t.integer "pka"
    t.integer "pkp"
    t.integer "pkf"
    t.integer "k4a"
    t.integer "k4p"
    t.integer "k4f"
    t.integer "k5a"
    t.integer "k5p"
    t.integer "k5f"
    t.integer "grade1"
    t.integer "grade2"
    t.integer "grade3"
    t.integer "grade4"
    t.integer "grade5"
    t.integer "grade6"
    t.integer "eug"
    t.integer "grade7"
    t.integer "grade8"
    t.integer "grade9"
    t.integer "grade10"
    t.integer "grade11"
    t.integer "grade12"
    t.integer "sug"
    t.integer "total"
  end

  create_table "public_schools", primary_key: "school_id", id: :integer, force: :cascade do |t|
    t.string  "school_name", limit: 100
    t.integer "aun"
  end

  create_table "school_assessment_names", id: false, force: :cascade do |t|
    t.integer "school_id"
    t.string  "lea_name",    limit: 200
    t.string  "school_name", limit: 200
  end

  create_table "school_assessment_results", primary_key: ["school_id", "subject", "grade", "student_group"], force: :cascade do |t|
    t.integer "school_id",                   null: false
    t.string  "subject",         limit: 1,   null: false
    t.string  "grade",           limit: 20,  null: false
    t.string  "student_group",   limit: 100, null: false
    t.integer "n_scored"
    t.string  "pct_advanced",    limit: 20
    t.string  "pct_proficient",  limit: 20
    t.string  "pct_basic",       limit: 20
    t.string  "pct_below_basic", limit: 20
    t.string  "growth",          limit: 20
  end

  create_table "test", id: false, force: :cascade do |t|
    t.string "col1", limit: 10
    t.string "col2", limit: 10
  end

  create_table "versions", id: false, force: :cascade do |t|
    t.string   "major",   limit: 5
    t.string   "minor",   limit: 5
    t.datetime "date",                default: -> { "now()" }
    t.string   "creator", limit: 20
    t.string   "comment", limit: 200
  end

end
