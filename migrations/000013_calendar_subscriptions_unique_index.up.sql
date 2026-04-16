CREATE UNIQUE INDEX uniq_calendar_subscriptions_calendar_ip_ua
ON calendar_subscriptions(calendar_id, ip_hash, user_agent)
WHERE ip_hash IS NOT NULL AND user_agent IS NOT NULL;