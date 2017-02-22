package core

import (
	"github.com/tapglue/snaas/service/app"
	"github.com/tapglue/snaas/service/rule"
)

// RuleListFunc returns all rules for the current App.
type RuleListFunc func(appID uint64) (rule.List, error)

// RuleList returns all rules for the current App.
func RuleList(apps app.Service, rules rule.Service) RuleListFunc {
	return func(appID uint64) (rule.List, error) {
		currentApp, err := AppFetch(apps)(appID)
		if err != nil {
			return nil, err
		}

		return rules.Query(currentApp.Namespace(), rule.QueryOptions{
			Deleted: &defaultDeleted,
		})
	}
}

// RuleListActiveFunc returns all active rules for the current App.
type RuleListActiveFunc func(*app.App, rule.Type) (rule.List, error)

// RuleListActive returns all active rules for the current App.
func RuleListActive(rules rule.Service) RuleListActiveFunc {
	return func(currentApp *app.App, ruleType rule.Type) (rule.List, error) {
		return rules.Query(currentApp.Namespace(), rule.QueryOptions{
			Active:  &defaultActive,
			Deleted: &defaultDeleted,
			Types: []rule.Type{
				ruleType,
			},
		})
	}
}
