News.seed(
  {
    id: 1,
    title: "お知らせ-1",
    content: Faker::Lorem.sentence(word_count: 20),
    delivered_at: DateTime.now.yesterday,
    status: 'published'
  },
  {
    id: 2,
    title: "お知らせ-2",
    content: Faker::Lorem.sentence(word_count: 20),
    delivered_at: DateTime.now.yesterday,
    status: 'published'
  },
  {
    id: 3,
    title: "お知らせ-3",
    content: Faker::Lorem.sentence(word_count: 20),
    delivered_at: DateTime.now.yesterday,
    status: 'published'
  },
  {
    id: 4,
    title: "お知らせ-4",
    content: Faker::Lorem.sentence(word_count: 20),
    delivered_at: DateTime.now.yesterday,
    status: 'published'
  },
  {
    id: 5,
    title: "お知らせ-5",
    content: Faker::Lorem.sentence(word_count: 20),
    delivered_at: DateTime.now.yesterday,
    status: 'published'
  }
)
