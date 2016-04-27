define acmetool::desire (
	$domain = undef,
	$additional = undef
) {
	if $domain == undef { fail("domain must be set!") }
	validate_string($domain)

	if $additional == undef {
		$content = ""
	} else {
		validate_array($additional)
		$content_head = "names:\n\t- "
		$all_domains = concat([$domain], $additional)
		$content_foot = join($all_domains, "\n\t- ")
		$content = "$content_head$content_foot"
	}

	file {"/var/lib/acme/desired/$domain":
		ensure => file,
		content => $content,
	}
}
