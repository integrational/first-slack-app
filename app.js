const process = require('process')
const { App, Logger, LogLevel } = require('@slack/bolt')

// Initializes your app with your bot token and signing secret
const app = new App({
  signingSecret: process.env.SLACK_SIGNING_SECRET,
  appToken: process.env.SLACK_APP_TOKEN,
  token: process.env.SLACK_BOT_TOKEN,
  socketMode: false,
  port: process.env.PORT || 3000,
  logLevel: LogLevel.DEBUG
})

app.event('app_home_opened', async ({ event, client, context }) => {
  const userId = event.user // the user that opened your app's app home
  console.info('Received event app_home_opened from user ' + userId)

  try {
    const result = await client.views.publish({
      user_id: userId,
      view: {
        type: "home", // Home tabs must be enabled in your app configuration page under "App Home"
        blocks: [
          {
            type: "section",
            text: {
              type: "mrkdwn",
              text: "*Welcome home, <@" + userId + "> :house:*"
            }
          },
          {
            type: "section",
            text: {
              type: "mrkdwn",
              text: "Learn how home tabs can be more useful and interactive <https://api.slack.com/surfaces/tabs/using|*in the documentation*>."
            }
          },
          {
            type: "divider"
          },
          {
            type: "context",
            elements: [
              {
                type: "mrkdwn",
                text: "A First Slack App using Bolt for JS"
              }
            ]
          }
        ]
      }
    })
    console.debug(result)
  }
  catch (error) {
    console.error(error)
  }
})

// enable graceful interrupt
process.on('SIGINT', () => process.exit(0))

  ; // to fix auto-intendation
(async () => {
  await app.start()
  console.info('A First Slack App using Bolt for JS has started!')
})()
