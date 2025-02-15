module.exports = {
  branches: [
    { name: "main" }
  ],
  plugins: [
    "@semantic-release/commit-analyzer",
    "@semantic-release/changelog",
    [
      "@semantic-release/release-notes-generator",
      {
        writerOpts: {
          groupBy: "type",
          commitGroupsSort: "title",
          commitsSort: ["scope", "subject"],
          noteGroupsSort: "title",
          commitGroupsTitle: (group) => {
            const typeEmojis = {
              feat: "✨ Features",
              fix: "🛠 Bug Fixes",
              docs: "📝 Documentation",
              style: "🎨 Code Style",
              refactor: "♻️ Refactoring",
              perf: "⚡️ Performance Improvements",
              test: "✅ Tests",
              chore: "🔧 Chores"
            };
            return typeEmojis[group.title] || "❓ Other";
          },
          transform: (commit, context) => {
            const hash = commit.hash ? ` ([${commit.hash.substring(0, 7)}](https://github.com/${context.repository}/commit/${commit.hash}))` : "";
            return `- ${commit.subject}${hash}`;
          },
          headerPartial: "# 🍕 Release Notes\n\n"
        }
      }
    ],
    ["@semantic-release/github", {
      "draft": true
    }]
  ]
};