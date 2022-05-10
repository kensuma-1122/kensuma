News.seed(
  {
    id: SecureRandom.uuid,
    title: "お知らせ-1",
    content: Faker::Lorem.sentence(word_count: 20),
    delivered_at: DateTime.now.yesterday,
    status: 'published'
  },
  {
    id: SecureRandom.uuid,
    title: "お知らせ-2",
    content: Faker::Lorem.sentence(word_count: 20),
    delivered_at: DateTime.now.yesterday,
    status: 'published'
  },
  {
    id: SecureRandom.uuid,
    title: "お知らせ-3",
    content: Faker::Lorem.sentence(word_count: 20),
    delivered_at: DateTime.now.yesterday,
    status: 'published'
  },
  {
    id: SecureRandom.uuid,
    title: "お知らせ-4",
    content: Faker::Lorem.sentence(word_count: 20),
    delivered_at: DateTime.now.yesterday,
    status: 'published'
  },
  {
    id: SecureRandom.uuid,
    title: "お知らせ-5",
    content: Faker::Lorem.sentence(word_count: 20),
    delivered_at: DateTime.now.yesterday,
    status: 'published'
  }
)
