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
              chore: "🔧 Chores",
              null: "❓ Other"
            };
            return typeEmojis[group.title] || "❓ Other";
          },
          transform: (commit, context) => {
            const typeEmojis = {
              feat: "✨",
              fix: "🛠",
              docs: "📝",
              style: "🎨",
              refactor: "♻️",
              perf: "⚡️",
              test: "✅",
              chore: "🔧"
            };
      
            commit.type = commit.type || null;
            commit.groupTitle = typeEmojis[commit.type] || "❓";
            commit.shortHash = commit.hash ? commit.hash.substring(0, 7) : "";
            commit.subject = commit.subject || "";
      
            return commit;
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