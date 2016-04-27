require 'spec_helper'

describe 'acmetool::desire' do
	let (:title) { 'foo' }

	context 'default-params' do
		it { is_expected.to raise_error(Puppet::Error, /domain must be set!/) }
	end

	context 'one-domain' do
		let (:params) { { :domain => 'www.example.com' } }
		it {
			is_expected.to compile.with_all_deps
			is_expected.to create_file("/var/lib/acme/desired/www.example.com")
		}
	end

	context 'domain-array' do
		let (:params) { { :domain => ['foo', 'bar'] } }
		it { is_expected.to raise_error(Puppet::Error, /\["foo", "bar"\] is not a string.  It looks to be a Array/) }
	end

	context 'one-domain-with-add-string' do
		let (:params) { { :domain => 'www.example.com', :additional => 'stage.example.com' } }
		it { is_expected.to raise_error(Puppet::Error, /"stage.example.com" is not an Array.  It looks to be a String/) }
	end

	context 'one-domain-with-add-array' do
		let (:params) { { :domain => 'www.example.com', :additional => ['stage.example.com', 'www.example.org'] } }
		it {
			is_expected.to compile.with_all_deps
			is_expected.to create_file("/var/lib/acme/desired/www.example.com")
				.with_content("names:\n\t- www.example.com\n\t- stage.example.com\n\t- www.example.org")
		}
	end

end

