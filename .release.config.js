module.exports = {
  branches: ["main"],
  plugins: [
    "@semantic-release/commit-analyzer",
    "@semantic-release/changelog",
    [
      "@semantic-release/release-notes-generator",
      {
        writerOpts: {
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

            if (typeEmojis[commit.type]) {
              commit.type = `${typeEmojis[commit.type]} ${commit.type}`;
            } else {
              commit.type = `${typeEmojis['fix']} fix`;
            }
            
            return commit;
          },
          groupBy: "type",
          commitGroupsSort: "title",
          commitsSort: ["scope", "subject"],
          noteGroupsSort: "title",
          mainTemplate: `
# 🚀 Release Notes

{{#each commitGroups}}
## {{title}}

{{#each commits}}
- {{this.subject}}
{{/each}}

{{/each}}
`
        }
      }
    ],
    [
      "@semantic-release/git",
      {
        assets: ["CHANGELOG.md", "package.json"],
        message: "chore(release): 🔖 v${nextRelease.version}\n\n${nextRelease.notes}"
      }
    ],
    "@semantic-release/github"
  ]
};
