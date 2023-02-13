## Project Setup

Included in this ZIP file is a Rails 5 RESTful API application. It has been stripped down to remove authentication and extraneous code that you don't need to worry about. Getting up and running should be fairly easy (assuming you use a command line and have RVM or some Rubygem manager installed):

```
gem install bundler
bundle install
chmod 755 rundev
./rundev
```

The project uses sqlite and the database file is provided with migrations and a seed file for initial, basic, data.

```
http://localhost:5000/
http://localhost:5000/reports/events/1/speakers
```

## Challenges

We received the following support tickets from our Customer Support team on behalf of a very important client. They have integrated our API into their own internal system and therefore access the API directly. Their contract with us states that we will provide any requested report end-points and data. Fix each issue and add the requested reports.

### Ticket 1

```
When accessing the attendee report (reports/conferences/1/attendees) it will often time-out when there are more than a few thousand attendees. When it doesn't time out, there is often too much data for our ancient app to ingest at once.
```

### Ticket 2

```
We would like to send an email to all of the speakers for an event and I found duplicates on the speakers report (reports/events/1/speakers). Can you ensure this report doesn't return any duplicate emails?
```

### Ticket 3

```
I'm able to get a report of all the speakers for an event, but not all of the attendees (for all conferences in the event). Can you add an end-point: reports/events/<<event id>>/attendees ? I'd also like to exclude duplicates (by email address).
```

### Ticket 4

```
I need a report that lists all of the conferences for any given event. I need to know how many attendees each conference had, how many the event had (excluding duplicates), and I need a list of speakers for each conference. End point: reports/events/<<event id>> -- should also include event data.
```

### Ticket 5

```
Users are creating duplicate attendee data that is causing data to not be clean. We would like to see a sanitized list of all unique attendees for an event.
```

### Ticket 6

```
We have a user that wants us to integrate some external data into our system. API Documentation located https://api.publicapis.org/

We need to pull this information under the below Acceptance Criteria:

1. As a user pulling this data, I only want data that uses `apiKey` as Auth.
2. As a user pulling this data, I want the data organized by `Category`.
```

## Some Advice

  - Carefully read over each ticket before crafting your solution. Make sure you are solving for the client’s needs.

  - Be aware that this project uses sqlite -- some features that are available for Postgres or Mysql may not be available but any gems that work with ActiveRecord should work.

  - Treat the data as though it were production data on a production website. Assume that clients pay a premium for secure, long-term, historical data storage that is used to verify professional certifications issued by government entities.

  - You are free to add gems if you find any that might be useful to you.

  - You are welcome to optimize and change existing code if it’s related to a ticket. If you think something is inefficient or could be done in a better way, don't be afraid to make changes!

  - Look at the entire codebase before you begin. Learn how the project has been organized and ensure your solution works within the architecture of the project.

  - Ensure you apply good API housekeeping and conform with standard RESTful API “conventions” typically seen in real-world applications.

  - We intentionally removed some things from the application that are not relevant (such as OAuth authentication), including a test suite. You are not required to add a test suite nor write tests for your code. However, if you would like to, please use rspec as that is the suite we use in all our applications here at Blue Sky.

## Submission

There is no deadline to return your solution. When you're done, zip up the project and email it to jmilam@blueskyelearn.com
